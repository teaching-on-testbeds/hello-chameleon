all: index.md hello_chameleon.ipynb

clean: 
	rm index.md hello_chameleon.ipynb

index.md: prepare.md footer.md notebooks/*.md
	pandoc --resource-path=images/ --wrap=none \
                -i prepare.md \
		notebooks/reserve.md notebooks/login.md \
                notebooks/transfer.md notebooks/linux.md notebooks/delete.md \
                --metadata title="Hello, Chameleon" -o index.tmp.md
	grep -v '^:::' index.tmp.md > index.md
	rm index.tmp.md
	cat footer.md >> index.md

hello_chameleon.ipynb: notebooks/*.md
	pandoc --resource-path=../ --embed-resources --standalone --wrap=none \
                -i notebooks/title.md \
                notebooks/reserve.md notebooks/login.md \
                notebooks/transfer.md notebooks/linux.md notebooks/delete.md \
                -o hello_chameleon.ipynb  
	sed -i 's/attachment://g' hello_chameleon.ipynb


