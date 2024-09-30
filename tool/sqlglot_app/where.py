from icecream import ic

ic.configureOutput(includeContext=True, argToStringFunction=str)
ic.lineWrapWidth = 120

from sqlglot import parse_one, expressions, exp
from sqlglot.optimizer.scope import build_scope


sqls = [
    "SELECT device.name AS device_name, SUM(smd.dosage) AS total_dosage FROM app_tenant at JOIN asset_system sys ON at.project_id = sys.project_id JOIN asset_gauge_table agt ON sys.system_id = agt.system_id JOIN asset_device device ON agt.gauge_table_id = device.gauge_table_id JOIN stats_month_device smd ON device.device_id = smd.device_id WHERE at.name = '东莞星河城' AND device.name IN ('1号冷冻泵', '01号冷冻泵', '2号冷冻泵', '02号冷却塔') AND ((smd.year = 2023 AND smd.month >= 12) OR (smd.year = 2024 AND smd.month <= 11)) GROUP BY device.name ORDER BY device.name;",
    "SELECT sys.system_name AS system_name, SUM(smd.dosage) AS total_dosage FROM app_tenant at JOIN asset_system sys ON sys.project_id = at.project_id JOIN asset_gauge_table agt ON sys.system_id = agt.system_id JOIN asset_device device ON agt.gauge_table_id = device.gauge_table_id JOIN stats_month_device smd ON device.device_id = smd.device_id WHERE at.NAME = '厦门乾照光电有限公司' AND sys.system_name = '水冷系统' AND smd.YEAR = 2023 AND smd.MONTH BETWEEN 10 AND 12;",
]
SELECTED_COLUMNS = ("at.name", "sys.system_name", "device.name")


def traverse(node, selected_values):
    for key, value in node.items():
        ic(key, type(value), value)
        if isinstance(value, (exp.And, exp.Or)):
            traverse(value.args, selected_values)
        elif isinstance(value, exp.EQ):
            # value: sys.system_name = '水冷系统'
            # get the left and right side of the expression
            column = str(value.left)
            right = str(value.right)
            if column.lower() in SELECTED_COLUMNS:
                selected_values[column] = eval(str(right))
        elif isinstance(value, exp.In):
            # value: device.name IN ('1号冷冻泵', '01号冷冻泵', '2号冷冻泵', '02号冷却塔')
            # get the items of the IN clause which does not have a left attribute
            column = str(value.this)
            if column.lower() in SELECTED_COLUMNS:
                items = [eval(str(item)) for item in value.expressions]
                ic(column, items)
                selected_values[column] = items


def get_device_info(sql):
    ast = parse_one(sql)
    where = ast.find(exp.Where)
    selected_values = {}
    traverse(where.args, selected_values)
    return selected_values


for sql in sqls:
    # ic(where, repr(where))

    # ic(where.args, type(where.args))

    # write code to traverse the where clause to get all conditions
    values = get_device_info(sql)
    ic(values)
