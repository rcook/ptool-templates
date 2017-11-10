{{java_copyright}}
package {{reversed_domain}};

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for Widget class
 */
public final class WidgetTest extends TestCase
{
    /**
     * Create the test case
     *
     * @param testName name of the test case
     */
    public WidgetTest(String testName)
    {
        super(testName);
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite()
    {
        return new TestSuite(WidgetTest.class);
    }

    /**
     * Example test
     */
    public void testJoin()
    {
        Widget widget = new Widget();
        String result = widget.join("aaa", "bbb");
        assertEquals("aaabbb", result);
    }
}
