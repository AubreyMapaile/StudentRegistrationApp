# Variables
$glassfishBin   = "C:\glassfish8\glassfish\bin"   # adjust to your GlassFish bin folder
$appName        = "StudentsRegistration"
$warFile        = "target\StudentsRegistration.war"
$adminUser      = "admin"
$adminPassword  = "Newmark@8"
$pwdFile        = "$glassfishBin\gfpass.txt"

# Create/overwrite password file
"AS_ADMIN_PASSWORD=$adminPassword" | Out-File -FilePath $pwdFile -Encoding ASCII


Write-Host "Undeploying $appName..."
Set-Location $glassfishBin
asadmin.bat --user $adminUser --passwordfile $pwdFile undeploy $appName 2>$null

$projectDir = "C:\Users\aubre\StudentRegistrationApp"

Write-Host "Building project with Maven..."
Set-Location $projectDir
mvn.cmd clean package

Write-Host "Deploying $warFile..."
Set-Location $glassfishBin
& .\asadmin.bat --user $adminUser --passwordfile $pwdFile deploy "$projectDir\$warFile"

Set-Location $projectDir
Write-Host "Deployment complete!"