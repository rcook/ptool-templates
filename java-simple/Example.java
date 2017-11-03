{{java_copyright}}
package {{reversed_domain}};

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
