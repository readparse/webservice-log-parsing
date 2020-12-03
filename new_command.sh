
 ls data/*.gz | while read i
do
echo $i; echo $i | perl -lne '@matches = /(\.gz)/g; shift @matches; print join(" | ", "gunzip -c $_" , map {"gunzip -c"} @matches)' | sh > foo.log
perl parse_log_file.pl foo.log >> full_output.log
rm foo.log
done
