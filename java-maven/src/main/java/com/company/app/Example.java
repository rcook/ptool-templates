{{java_copyright}}
package com.{{java_company_name}}.app;

/**
 * Example class
 */
public final class Example
{
    public Example(int operand)
    {
        _operand = operand;
    }

    public int add(int otherOperand)
    {
        return _operand + otherOperand;
    }

    private final int _operand;
}
