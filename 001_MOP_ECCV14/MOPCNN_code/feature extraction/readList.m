function lst = readList(fpath, formatstr)
f = fopen(fpath);
lst = textscan(f, formatstr);
lst = lst{1};
fclose(f);

