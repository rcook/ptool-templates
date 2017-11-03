{{java_copyright}}
package {{reversed_domain}};

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public final class SampleControllerTest extends TestCase
{
    public SampleControllerTest(String testName)
    {
        super(testName);
    }

    public static Test suite()
    {
        return new TestSuite(SampleControllerTest.class);
    }

    public void test()
    {
        assertTrue(true);
    }
}
