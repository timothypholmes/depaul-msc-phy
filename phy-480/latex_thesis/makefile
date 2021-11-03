file_name = main
job_name = tim_holmes_thesis

all: main

main:
	latexmk -pdf $(file_name).tex -jobname=$(job_name) 

.PHONY : clean
clean:
	rm -r -f *.aux *.log *.lof *.gz *.toc *.bak~ *.out *.bbl *.blg *.idx *.bcf *.lot *.run.xml *.fdb_latexmk *.fls
