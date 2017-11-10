{{java_copyright}}
package {{reversed_domain}};

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import {{reversed_domain}}.configuration.MvcConfig;

/**
 * Utility to initialize the Spring MVC application.
 */
public class {{package_base_name}}AppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer
{
    @Override
    protected Class<?>[] getRootConfigClasses()
    {
        return new Class[]
        {
            MvcConfig.class
        };
    }

    @Override
    protected Class<?>[] getServletConfigClasses()
    {
        return null;
    }

    @Override
    protected String[] getServletMappings()
    {
        return new String[]
        {
            "/"
        };
    }
}
