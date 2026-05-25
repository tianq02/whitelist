# Firewall rule generator

腾讯云防火墙配置仅允许100条规则，但CDN给出的回源IP白名单远不止100条

## usage:

1. 获取最新回源IP列表
2. 合并IP段（可选：验证合并结果）
3. 基于合并后的IP段，生成防火墙规则

```bash
nano eo.txt
./cidr-merge -t 98 -o eo98.txt eo.txt
./cidr-diff eo.txt eo98.txt
./convert.sh
cat firewall_rules.csv
```
