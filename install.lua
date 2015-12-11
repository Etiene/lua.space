local dependencies = {
	"date"
}

os.execute("luarocks install "..table.concat(dependencies,' '))