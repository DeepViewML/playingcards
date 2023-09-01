import json


def format_value(value):
    if isinstance(value, bool):
        return str(value).lower()
    elif isinstance(value, list):
        return "[" + ", ".join(format_value(item) for item in value) + "]"
    else:
        return str(value)


def json_to_markdown(json_data, indent=0):
    markdown = ""
    for key, value in json_data.items():
        if isinstance(value, dict):
            markdown += f"{' ' * indent}- **{key}**:\n{json_to_markdown(value, indent + 4)}"
        elif isinstance(value, list):
            markdown += f"{' ' * indent}- **{key}**: {format_value(value)}\n"
        else:
            markdown += f"{' ' * indent}- **{key}**: {format_value(value)}\n"
    return markdown


with open('out/config.json', 'r') as f:
    json_data = json.load(f)

with open('out/config.md', 'w') as f:
    f.write(json_to_markdown(json_data))
