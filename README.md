# IdentityValidator
IdentityValidator checks if your executor is faking printidentity or not.

# Checks
- printidentitycclosure
    - Checks if printidentity is a cclosure
- getthreadidentitynotequal
    - getthreadidentity is not equal to printidentity level
- invalididentity
    - if identity is lower than 0 or higher than 9
- printidentitylowargs
    - printidentity does not have the prefix arg
- identitycheck
    - MoreUNC's getthreadidentity function used to tell if the identity is being faked or not

# Credits
- UNC NamingStandard: UNCCheckEnv @ https://github.com/unified-naming-convention/NamingStandard/blob/main/UNCCheckEnv.lua
- MoreUNC v2.0.0: for getthreadidentity @ https://rawscripts.net/raw/Universal-Script-MoreUNC-V2-15902

# Note
im still learning shi', if u want, you can pr 🙏

u can fork this, but dont modify anything and credit me, and possibly everyone i credit 👍