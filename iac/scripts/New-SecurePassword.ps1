# Generate a secure password following Azure best practices
# Meets requirements for both Azure SQL and Azure VMs:
# - 12-128 characters
# - Contains uppercase, lowercase, numbers, and special characters
# - No ambiguous characters (0, O, I, l, 1)

function New-SecurePassword {
    param(
        [int]$Length = 20
    )
    
    # Character sets (excluding ambiguous characters)
    $uppercase = "ABCDEFGHJKLMNPQRSTUVWXYZ"
    $lowercase = "abcdefghijkmnopqrstuvwxyz"
    $numbers = "23456789"
    $special = "!@#$%^&*"
    
    # Ensure we have at least one from each category
    $password = @(
        $uppercase[(Get-Random -Maximum $uppercase.Length)]
        $lowercase[(Get-Random -Maximum $lowercase.Length)]
        $numbers[(Get-Random -Maximum $numbers.Length)]
        $special[(Get-Random -Maximum $special.Length)]
    )
    
    # Fill the rest with random characters from all sets
    $allChars = $uppercase + $lowercase + $numbers + $special
    for ($i = 4; $i -lt $Length; $i++) {
        $password += $allChars[(Get-Random -Maximum $allChars.Length)]
    }
    
    # Shuffle the password
    $shuffled = $password | Get-Random -Count $password.Length
    
    return -join $shuffled
}
