.PHONY: all dats figs clean-dats clean-figs clean-all

# run entire analysis 
all: report/count_report.html 

# count words
dats: results/isles.dat \
results/abyss.dat \
results/last.dat \
results/sierra.dat

# Count the words 
results/isles.dat: data/isles.txt scripts/wordcount.py
	python scripts/wordcount.py \
    	--input_file=data/isles.txt \
    	--output_file=results/isles.dat

results/abyss.dat: data/abyss.txt scripts/wordcount.py
	python scripts/wordcount.py \
		--input_file=data/abyss.txt \
		--output_file=results/abyss.dat

results/last.dat: data/last.txt scripts/wordcount.py
	python scripts/wordcount.py \
		--input_file=data/last.txt \
		--output_file=results/last.dat

results/sierra.dat: data/sierra.txt scripts/wordcount.py
	python scripts/wordcount.py \
		--input_file=data/sierra.txt \
		--output_file=results/sierra.dat
	
#create plots 

figs : results/figure/isles.png \
    results/figure/abyss.png \
    results/figure/last.png \
    results/figure/sierra.png

results/figure/isles.png: results/isles.dat scripts/plotcount.py
	python scripts/plotcount.py \
		--input_file=results/isles.dat \
		--output_file=results/figure/isles.png

results/figure/abyss.png: results/abyss.dat scripts/plotcount.py
	python scripts/plotcount.py \
		--input_file=results/abyss.dat \
		--output_file=results/figure/abyss.png

results/figure/last.png: results/last.dat scripts/plotcount.py
	python scripts/plotcount.py \
		--input_file=results/last.dat \
		--output_file=results/figure/last.png

results/figure/sierra.png: results/sierra.dat scripts/plotcount.py
	python scripts/plotcount.py \
		--input_file=results/sierra.dat \
		--output_file=results/figure/sierra.png

# renders report 
report/count_report.html: report/count_report.qmd results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
	quarto render report/count_report.qmd

clean-dats :
	rm -f results/isles.dat \
		  results/abyss.dat \
		  results/last.dat \
		  results/sierra.dat

clean-figs :
	rm -f results/figure/isles.png \
		  results/figure/abyss.png \
		  results/figure/last.png \
		  results/figure/sierra.png

clean-all : clean-dats \
    clean-figs
	rm -rf report/count_report.html \
		  count_report_files