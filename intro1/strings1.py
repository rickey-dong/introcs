def closer_number(num1, num2, num3):
    if abs(num3 - num1) > abs(num3 - num2):
        x = str(num2) + " is closer to " + str(num3)
        return x
    else:
        y = str(num1) + " is closer to " + str(num3)
        return y
    
print(closer_number(7, 16, 10))
print(closer_number(20, 3, 8))
print(closer_number(-5, 8, 0))

def num_table(a, b):
    HTMLCode = """
                <style>
                    table, th, td {
                    border: 1px solid black;
                    }
                </style>
                <table>
                    <tr>
                        <th>n</th>
                        <th>n^2</th>
                        <th>sqrt n</th>
                    </tr>
                    """
    while a <= b:
        HTMLCode += """
                    <tr>
                        <td>""" + str(a) + """</td>"""
        HTMLCode += """
                        <td>""" + str(a ** 2) + """</td>"""
        HTMLCode += """
                        <td>""" + str(a ** (1/2)) + """</td>"""
        a += 1
    HTMLCode += """
                    </table>"""
    return HTMLCode

print(num_table(1, 4))