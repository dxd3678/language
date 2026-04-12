# 中国地域划分字典结构 - 拆分定义方式

# 1. 先定义各个省份的数据
shanxi_province = {
    "name": "山西省",
    "capital": "太原市",
    "cities": [
        {"name": "太原市", "type": "省会"},
        {"name": "大同市", "type": "地级市"},
        {"name": "阳泉市", "type": "地级市"},
        {"name": "长治市", "type": "地级市"},
        {"name": "晋城市", "type": "地级市"},
        {"name": "朔州市", "type": "地级市"},
        {"name": "晋中市", "type": "地级市"},
        {"name": "运城市", "type": "地级市"},
        {"name": "忻州市", "type": "地级市"},
        {"name": "临汾市", "type": "地级市"},
        {"name": "吕梁市", "type": "地级市"}
    ]
}

zhejiang_province = {
    "name": "浙江省",
    "capital": "杭州市",
    "cities": [
        {"name": "杭州市", "type": "省会"},
        {"name": "宁波市", "type": "副省级市"},
        {"name": "温州市", "type": "地级市"},
        {"name": "嘉兴市", "type": "地级市"},
        {"name": "湖州市", "type": "地级市"},
        {"name": "绍兴市", "type": "地级市"},
        {"name": "金华市", "type": "地级市"},
        {"name": "衢州市", "type": "地级市"},
        {"name": "舟山市", "type": "地级市"},
        {"name": "台州市", "type": "地级市"},
        {"name": "丽水市", "type": "地级市"}
    ]
}

# 2. 创建空的 country 字典
country = {
    "name": "China",
    "provinces": {}
}

# 3. 方法一：直接赋值方式添加省份
country["provinces"]["shanxi"] = shanxi_province
country["provinces"]["zhejiang"] = zhejiang_province

# 方法二：使用 update() 方法批量添加（注释掉的示例）
# country["provinces"].update({
#     "shanxi": shanxi_province,
#     "zhejiang": zhejiang_province
# })

# 使用示例：

# 1. 获取国家名称
print("国家：", country["name"])

# 2. 获取浙江省信息
print("\n浙江省省会：", country["provinces"]["zhejiang"]["capital"])

# 3. 获取山西省的所有城市，通过 for 循环来变量 list


print("\n山西省的城市：")
for city in country["provinces"]["shanxi"]["cities"]:
    print(f"  - {city['name']} ({city['type']})")

# 4. 遍历所有省份
print("\n所有省份：")
for province_key, province_data in country["provinces"].items():
    print(f"  {province_data['name']}: {len(province_data['cities'])} 个城市")

# 5. 检查某个省份是否存在
if "zhejiang" in country["provinces"]:
    print("\n浙江省存在于数据中")

# 6. 使用 get() 方法安全访问
guangdong = country["provinces"].get("guangdong")
if guangdong:
    print("找到广东省")
else:
    print("\n广东省暂未定义")

# 7. use the pop function to delete item
print("provinces item cnt:", len(country["provinces"]))
country["provinces"].pop("shanxi", None)
print("provinces item cnt:", len(country["provinces"]))