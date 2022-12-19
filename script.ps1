# Source of dates
# In my example it has only one column "Date"
# Date must be in format: yyyy-MM-dd

$a = Import-Csv "dates.csv"

$report = "Date;Value"

foreach($b in $a)
{
  # create URI using date from file
  $uri = "https://wyborcza.biz/Waluty/0,112676,,,,WIBOR3M,"+$b.Date+".html"
  
  # getting web page data
  $r = Invoke-WebRequest -Uri $uri -WebSession $session
  
  # finding value
  $x = ($r.parsedhtml.getelementsbytagname("TR") |% { ( $_.children[1] | ?{ $_.tagName -eq "td"} | % innerText ) } | Select-Object -First 1)

  # preparing report [output data]
  $report = $report + "`n"
  $report = $report + $b.Date +";"+$x
}
# final data
$report
