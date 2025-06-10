# Definir la ruta donde se guardará el archivo JSON
$OutputPath = "C:\inetpub\wwwroot\host\ad_users.json"

# Definir la ruta base de la OU donde están los usuarios
$BaseOU = "OU=Usuarios,OU=TI,DC=ADADOM,DC=LOCAL"

# Obtener todas las OUs dentro de "Usuarios"
$OUs = Get-ADOrganizationalUnit -SearchBase $BaseOU -Filter *

# Crear un array para almacenar los datos
$Result = @()

foreach ($OU in $OUs) {
    # Obtener los usuarios dentro de cada OU
    $Users = Get-ADUser -SearchBase $OU.DistinguishedName -Filter * -Property SamAccountName, Name, Mail

    # Crear un objeto con la información de la OU y sus usuarios
    $OUData = @{
        "OU" = $OU.Name
        "Usuarios" = @()
    }

    foreach ($User in $Users) {
        # Agregar los datos de cada usuario
        $OUData["Usuarios"] += @{
            "Usuario" = $User.SamAccountName
            "Nombre Completo" = $User.Name
            "Correo" = $User.Mail
        }
    }

    # Agregar la información de la OU al resultado final
    $Result += $OUData
}

# Convertir el resultado a JSON y guardarlo en el archivo
$Result | ConvertTo-Json -Depth 3 | Out-File -Encoding utf8 $OutputPath

Write-Host "Archivo JSON generado correctamente en $OutputPath"

