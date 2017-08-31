#!/bin/bash
#
# @sacloud-once
# @sacloud-desc-begin
# このスクリプトは usacloud をセットアップします
# （このスクリプトは、CentOS7.X で動作します）
#
# 事前作業として以下の1つが必要となります
# ・さくらのクラウドAPIのアクセストークンを取得していること
# @sacloud-desc-end
# @sacloud-require-archive distro-centos distro-ver-7
# @sacloud-select-begin required default=default ZONE "操作対象ゾーンを選択してください。(defaultはサーバを作成したゾーンになります)
#  default "default"
#  is1a "is1a"
#  is1b "is1b"
#  tk1a "tk1a"
#  tk1v "tk1v"
# @sacloud-select-end
# @sacloud-apikey required permission=create AK "APIキー"
# jq and bash-completion install
yum install -y yum-utils bash-completion
yum-config-manager --enable epel
yum install -y jq
# usacloud install
curl -fsSL https://usacloud.b.sakurastorage.jp/repos/setup-yum.sh | sh
# get zone name
ZONE=@@@ZONE@@@
if [ "${ZONE}" = "default" ]
then
  ZONE=$(jq -r ".Zone.Name" /root/.sacloud-api/server.json)
fi
# setup usacloud
usacloud config --token ${SACLOUD_APIKEY_ACCESS_TOKEN}
usacloud config --secret ${SACLOUD_APIKEY_ACCESS_TOKEN_SECRET}
usacloud config --zone ${ZONE}
exit 0