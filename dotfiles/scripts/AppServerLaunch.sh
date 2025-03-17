options=("DeskApi" "DeskMarketPlace" "DeskPlus1"  "DeskPlus2"  "DeskPlus3"  "DeskPlus4"  "DeskPlus5"  "DeskPlus6"  "DeskPlus7"  "DeskPlus8"  "DeskPlus9")
selected=$(printf '%s\n' "${options[@]}" | fzf)

# function exceptions(){
#     cd "~/eclipse_ws_new/deployment/zohodesk/AdventNet/Sas/logs"
#     tail -F zoho-support-application0.txt | grep --color -E "Exception|$"
# }

password="zJea-LzFQv" 
function appserver_connect_impl(){
    echo $password | pbcopy
    ssh $1
    exit 0
}
function appserver_connect(){

    mappings=(
        DeskApi sas@172.20.64.43
        DeskMarketPlace sas@172.20.9.27
        DeskPlus1 sas@172.20.9.27
        DeskPlus2 sas@172.20.24.111
        DeskPlus3 sas@172.20.5.241
        DeskPlus4 sas@172.20.36.12
        DeskPlus5 sas@172.20.42.128
        DeskPlus6 sas@172.20.46.189
        DeskPlus7 sas@172.20.47.0
        DeskPlus8 sas@172.20.97.119
        DeskPlus9 sas@172.20.97.122
    )

    echo connecting to "$selected"
    # echo "$mappings[DeskApi]"
    # appserver_connect_impl "${mappings[DeskApi]}"

    case "$selected" in
        "DeskApi")
            appserver_connect_impl "sas@172.20.64.43"
            ;;
        "DeskMarketPlace")
            appserver_connect_impl "sas@172.20.60.233"
            ;;
        "DeskPlus1")
            appserver_connect_impl "sas@172.20.9.27"
            ;;
        "DeskPlus2")
            appserver_connect_impl "sas@172.20.24.111"
            ;;
        "DeskPlus3")
            appserver_connect_impl "sas@172.20.5.241"
            ;;
        "DeskPlus4")
            appserver_connect_impl "sas@172.20.36.12"
            ;;
        "DeskPlus5")
            appserver_connect_impl "sas@172.20.42.128"
            ;;
        "DeskPlus6")
            appserver_connect_impl "sas@172.20.46.189"
            ;;
        "DeskPlus7")
            appserver_connect_impl "sas@172.20.47.0"
            ;;
        "DeskPlus8")
            appserver_connect_impl "sas@172.20.97.119"
            ;;
        "DeskPlus9")
            appserver_connect_impl "sas@172.20.97.122"
            ;;
        *)
            echo "Invalid option"
            echo $selected
            ;;
    esac
    # appserver_connect_impl "$mappings[$selected]"
}


appserver_connect
# function open_redis-cli(){
#     cd /opt/desk_software/redis-stable/src
#     ./redis-cli
# }
