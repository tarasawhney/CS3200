-- CS3200: Database Design
-- Homework #2: Genes and Disease

-- Create a new schema called "gad"
-- Then use the data import wizard to load the data "gad.csv" into a new table, also called "gad"
-- Remember to change the inferred datatype for the chromosome field from INT to TEXT
-- You should end up with a table containing 39,910 records


-- Write a query to answer each of the following questions
-- Save your script file as cs3200_hw2_lastname.sql
-- Submit this file for your homework submission
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

use gad;

-- 1a. (2.5 points)
-- Write a query that verifies that you have imported 39,910 records
SELECT count(*)
FROM gad; 

-- 1b. (2.5 points)
-- Write a query that lists the different columns in your gad table
-- Include a comment explaining why it was necessary to change the chromosome to a text field.
SELECT *
FROM gad; 
-- It was necessary to change the chromosome from an INT to a TEXT because it will throw out X and Y chromosomes if you don't 

-- 2. (5 points)
-- What are the distinct disease classes referenced in this data?
-- Output your list in alphabetical order
SELECT DISTINCT disease_class
FROM gad
ORDER BY disease_class; 

-- 3. (5 points)
-- List all distinct phenotypes related to the disease class "IMMUNE"
-- Output your list in alphabetical order
SELECT DISTINCT phenotype
FROM gad
WHERE disease_class = "IMMUNE"
ORDER BY phenotype; 

-- 4. (5 points)
-- List the gene symbol, gene name, and chromosome attributes related
-- to genes positively linked to asthma (association = Y).
-- Include in your output any phenotype containing the substring "asthma"
-- List each distinct record once
-- Sort by gene symbol
SELECT gene, gene_name, chromosome, chromosome_band, count(phenotype) AS phenotype
FROM gad
WHERE association = 'Y' AND phenotype LIKE '%asthma%'
GROUP BY gene, gene_name, chromosome, chromosome_band 
ORDER BY gene; 

-- 5. (5 points)
-- Explore the content of the various columns in your gad table.
-- List all genes that are "G protein-coupled" receptors in alphabetical order by gene symbol
-- Output the gene symbol, gene name, and chromosome
-- (These genes are often the target for new drugs, so are of particular interest)
SELECT gene, gene_name, chromosome
FROM gad
WHERE gene_name LIKE '%G protein-coupled%'
ORDER BY gene; 

-- 6. (5 points)
-- For genes on chromosome 3, what is the minimum, maximum DNA location
-- Exclude cases where the dna_start value is 0
SELECT min(dna_start), max(dna_end)
FROM gad
WHERE chromosome = 3 and dna_start != 0; 


-- 7 (10 points)
-- For each gene, what is the earliest and latest reported year
-- involving a positive association
-- Ignore records where the year isn't valid. (Explore the year column to determine what constitutes a valid year.)
-- Output the gene, min-year, max-year, and number of GAD records
-- order by min-year, max-year, gene (3-level sorting)
SELECT gene, min(year) as min_year, max(year) as max_year, COUNT(gad_id)
FROM gad
WHERE association = 'Y' and length(year) = 4
GROUP BY gene
ORDER BY min_year, max_year, gene; 

-- 8. (10 points)
-- How many records are there for each gene?
-- Output the gene symbol and name and the count of the number of records
-- Order by the record count in descending order
SELECT count(*), gene, gene_name
FROM gad
GROUP BY gene, gene_name
ORDER BY count(*) DESC; 

-- 9. (10 points)
-- Modify query 8 by considering only positive associations
-- and limit output to records having at least 100 associations
SELECT count(*), gene, gene_name
FROM gad
WHERE association = 'Y'
GROUP BY gene, gene_name
HAVING count(association) >= 100
ORDER BY count(*) DESC;  

-- 10. (10 points)
-- How many total GAD records are there for each population group?
-- Sort in descending order by count
-- Show only the top five records
-- Do NOT include cases where the population is blank
SELECT count(gad_id) AS total_gad_records, population 
FROM gad
WHERE population != ''
GROUP BY population
ORDER BY total_gad_records DESC
LIMIT 5; 

-- 11. (10 points)
-- In question 4, we found asthma-linked genes
-- But these genes might also be implicated in other diseases
-- Output gad records involving a positive association between ANY asthma-linked gene and ANY disease/phenotype
-- Sort your output alphabetically by phenotype
-- Output the gene, gene_name, association (should always be 'Y'), phenotype, disease_class, and population
-- Hint: Use a subselect in your WHERE class and the IN operator
SELECT gene, gene_name, association, phenotype, disease_class, population
FROM gad
WHERE association = 'Y' AND gene IN 
(SELECT gene
FROM gad
WHERE phenotype LIKE '%asthma%'); 

-- 12. (10 points)
-- Modify your previous query.
-- Let's count how many times each of these asthma-gene-linked phenotypes occurs
-- in our output table produced by the previous query.
-- Output just the phenotype, and a count of the number of occurrences for the top 5 phenotypes
-- with the most records involving an asthma-linked gene (EXCLUDING asthma itself).
SELECT phenotype, count(*)
FROM gad 
WHERE gene IN (
	 SELECT DISTINCT gene
     FROM gad 
     WHERE phenotype LIKE '%asthma%'
     AND association = 'Y')
AND association = 'Y' AND phenotype <> 'asthma'
GROUP BY phenotype 
ORDER BY count(*) DESC
LIMIT 5; 

-- 13. (10 points)
-- Interpret your analysis
-- Do an internet search and answer the following questions - (You can put your answer right into this script as comments.)

-- a) Does existing biomedical research support a connection between asthma and the disease you identified above?
-- Yes, according to a Finnish study from'the global diabetes community', having asthma increases the chance of Type 1 Diabetes by 41%. 
-- However, people with Type 1 Diabetes have a decreased chance of Asthma by 18%. 


-- b) Why might a drug company be interested in instances of such "overlapping" phenotypes?
-- Drug companies may be able to study patients with Asthma to determine if these patients could develop late 
-- onset diabetes

