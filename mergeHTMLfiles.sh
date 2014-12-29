#!/bin/bash
# http://www.linuxquestions.org/questions/linux-software-2/merge-of-html-files-into-a-single-html-or-pdf-284545/
read -ep "Enter directory path pages: " html_path
read -ep "Enter complete filename of the starting page: " start_page
ls $html_path > "list.txt";
grep -iv "</body>" "$html_path/$start_page" | grep -iv "</html>" > "$html_path/all_merged.html";
for i in $(< list.txt)
do
	grep -iv "<body>" "$html_path/$i" | grep -iv "<html>" | grep -iv "</body>" | grep -iv "</html>" >> "$html_path/all_merged.html"
done
echo "</body></html>" >> "$html_path/all_merged.html"
echo "Merged file ---> $html_path/all_merged.html"
# unset html_path;
# unset start_page;
# unset i;
