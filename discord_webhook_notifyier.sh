title=""
color=25373
author=""
authorthumb=""
thumb=""
description=""
fields=()
values=()
enable_author=false
enable_timestamp=false
json_string=""
hook=""

print_usage() {
  printf "Usage: ..."
}

remove_last_char() {
  json_string=${json_string%?}
}

append_to_json() {
  json_string="${json_string}${1}"
}

# Sets all vars to values according to flags
while getopts 'st:c:a:x:u:d:f:v:h:' opt; do
  case "${opt}" in
    s) enable_timestamp=true ;;
    t) title=${OPTARG} ;;
    c) color=${OPTARG} ;;
    a) author=${OPTARG} ; enable_author=true ;;
    x) authorthumb=${OPTARG} ; enable_author=true ;;
    u) thumb=${OPTARG} ;;
    d) description=${OPTARG} ;;
    f) fields+=("${OPTARG}") ;;
    v) values+=("${OPTARG}") ;;
    h) hook=${OPTARG} ;;
    *) print_usage
       exit 1 ;;
  esac
done

append_to_json '{"embeds":[{'

# handles timestamp
if [ $enable_timestamp = true ]
then
  date=$(date --utc +%FT%T.%3NZ)
  append_to_json '"timestamp":"'"${date}"'",'
fi

# handles title
if [ "" != "${title}" ]
then
  append_to_json '"title": "'${title}'",'
fi

# handles color
append_to_json '"color": '"${color}"','

# handles author related fields
if [ $enable_author = true ]
then
  append_to_json '"author":{'
  # handles author
  if [ "" != "${author}" ]
  then
    append_to_json '"name": "'"${author}"'",'
  fi
  # handles author picture
  if [ "" != "${authorthumb}" ]
  then
    append_to_json '"icon_url": "'"${authorthumb}"'",'
  fi
  remove_last_char
  append_to_json '},'
fi

# handles thumbnail
if [ "" != "${thumb}" ]
then
  append_to_json '"thumbnail":{"url":"'"${thumb}"'"},'
fi

# handles description
if [ "" != "${description}" ]
then
  append_to_json '"description":"'"${description}"'",'
fi

if [ ${#fields[@]} -gt 0 ]
then
  append_to_json '"fields":['

  for i in $(seq 0 $((${#fields[@]} - 1))); do
    append_to_json '{"name":"'"${fields[i]}"'","value":"'"${values[i]}"'"},'
  done

  remove_last_char
  append_to_json '],'
fi

remove_last_char
append_to_json '}]}'

curl -X POST -H "Content-Type: application/json" -d "${json_string}" "${hook}"
