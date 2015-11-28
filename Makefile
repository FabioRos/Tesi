all: clean
	@ pdflatex tesi.tex
	# @ makeglossaries tesi
	@ pdflatex tesi.tex
	@ pdflatex tesi.tex
	
analisi: _force
	@ find analisi -name '*.xml' | xargs -I {} xmllint --noout --schema analisi/usecase.xsd {}
	@ find analisi -name '*.xml' | grep -Eo '[^/]*$$' | grep -Eo '^[^.]*' | xargs -I {} xsltproc -o analisi/{}.tex analisi/usecase.xsl analisi/{}.xml
	@ find analisi -name '*.tex' | grep -Eo '[^/]*$$' | grep -Eo '^[^.]*' | xargs -I {} sed -i '' 's/%filename%/{}/g' analisi/{}.tex
	@ find analisi -name '*.tex' | grep -Eo '[^/]*$$' | grep -Eo '^UC[0-9][^.]*' | sort -k 14 | sort -k 13 | sort -k 12 | sort -k 11 | sort -k 10 | sort -k 9 | sort -k 8 | sort -k 7 | sort -k 6 | sort -k 5 |sort -k 4 | xargs -I {} cat analisi/{}.tex > analisi/usecase.tex

	@ node analisi/requisiti.js > analisi/requisiti.tex

clean: _force
	@rm -f *.out *.aux *.log *.toc *.lot *.lof *.ist *.glo *.gls *.glg
	@rm -f analisi/*.tex


_force:
