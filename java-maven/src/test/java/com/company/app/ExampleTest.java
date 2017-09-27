{{java_copyright}}
package com.{{java_company_name}}.app;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for Example class
 */
public final class ExampleTest extends TestCase
{
    /**
     * Create the test case
     *
     * @param testName name of the test case
     */
    public ExampleTest(String testName)
    {
        super(testName);
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite()
    {
        return new TestSuite(ExampleTest.class);
    }

    /**
     * Example test
     */
    public void testAdd()
    {
        Example example = new Example(5);
        int result = example.add(6);
        assertEquals(11, result);
    }
}
