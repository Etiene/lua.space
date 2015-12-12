local dependencies = {
	"sailor",
	"markdown",
	"date"
}

for _,d in ipairs(dependencies) do
	os.execute("luarocks install "..d)
end

