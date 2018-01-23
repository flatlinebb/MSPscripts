& vssadmin list writers | Select-String -Context 0,4 '^writer name:' | ? {
  $_.Context.PostContext[2].Trim() -ne "state: [1] stable" -or
  $_.Context.PostContext[3].Trim() -ne "last error: no error"
}