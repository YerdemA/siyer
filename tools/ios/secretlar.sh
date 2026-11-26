#!/usr/bin/env bash
# iOS iş akışlarının GitHub secret'larını YerdemA/siyer deposuna yazar.
# Değerler ekrana basılmaz; dosyalardan doğrudan `gh secret set`e gider.
#
#   bash tools/ios/secretlar.sh <Issuer ID> <uygulama profili> <indirici profili>
#
# Sertifika, parolası, API anahtarı ve Team ID, Kabaca'yla aynı hesaptan:
# ../Aralik/app-store/signing/ (yoksa KABACA_IMZA ile başka klasör ver).
set -euo pipefail

[ $# -eq 3 ] || { sed -n 2,9p "$0"; exit 2; }
issuer=$1 profil=$2 profil_indirici=$3
depo=YerdemA/siyer
kok=$(cd "$(dirname "$0")/../.." && pwd)
imza=${KABACA_IMZA:-$kok/../Aralik/app-store/signing}

for f in "$imza/IOS_DIST_CERT_P12.txt" "$imza/dist.p12.password" "$profil" "$profil_indirici"; do
  [ -f "$f" ] || { echo "Bulunamadı: $f" >&2; exit 1; }
done
anahtar=$(ls "$imza"/AuthKey_*.p8 2>/dev/null | head -1)
[ -n "$anahtar" ] || { echo "AuthKey_*.p8 bulunamadı: $imza" >&2; exit 1; }
key_id=$(basename "$anahtar" .p8); key_id=${key_id#AuthKey_}

# Team ID, uygulama profilinin içinden.
team=$(grep -a -A2 "<key>TeamIdentifier</key>" "$profil" | grep -ao "[A-Z0-9]\{10\}" | head -1)
[ ${#team} -eq 10 ] || { echo "Profilden Team ID okunamadı." >&2; exit 1; }

b64() { base64 -w0 "$1" 2>/dev/null || base64 "$1" | tr -d '\n'; }

printf '%s' "$team"    | gh secret set APPLE_TEAM_ID -R "$depo"
gh secret set IOS_DIST_CERT_P12 -R "$depo" < "$imza/IOS_DIST_CERT_P12.txt"
gh secret set IOS_DIST_CERT_PASSWORD -R "$depo" < "$imza/dist.p12.password"
b64 "$profil"          | gh secret set IOS_PROFILE -R "$depo"
b64 "$profil_indirici" | gh secret set IOS_PROFILE_INDIRICI -R "$depo"
printf '%s' "$key_id"  | gh secret set ASC_KEY_ID -R "$depo"
printf '%s' "$issuer"  | gh secret set ASC_ISSUER_ID -R "$depo"
gh secret set ASC_KEY_P8 -R "$depo" < "$anahtar"

gh secret list -R "$depo"
