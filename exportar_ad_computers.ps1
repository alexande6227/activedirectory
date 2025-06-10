# Definir la ruta donde se guardará el archivo JSON
$OutputPath = "C:\inetpub\wwwroot\host\ad_computers.json"

# Obtener todos los equipos del Active Directory
$Computers = Get-ADComputer -Filter * -Property Name, OperatingSystem, IPv4Address

# Crear un array para almacenar los datos
$Result = @()

foreach ($Computer in $Computers) {
    $Result += @{
        "Nombre" = $Computer.Name
        "SistemaOperativo" = $Computer.OperatingSystem
        "IP" = $Computer.IPv4Address
    }
}

# Convertir el resultado a JSON y guardarlo en el archivo
$Result | ConvertTo-Json -Depth 3 | Out-File -Encoding utf8 $OutputPath

Write-Host "Archivo JSON generado correctamente en $OutputPath"
