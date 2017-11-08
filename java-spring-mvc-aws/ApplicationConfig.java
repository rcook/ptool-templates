{{java_copyright}}
package {{reversed_domain}}.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;

import {{reversed_domain}}.controller.{{package_base_name}}Controller;

/**
 * Spring configuration for sample application.
 */
@Configuration
@ComponentScan({ "{{reversed_domain}}.configuration" })
@PropertySource("classpath:application.properties")
public final class ApplicationConfig
{
    /**
     * Retrieved from properties file.
     */
    @Value("${{ "{" }}{{package_base_name}}.SiteName}")
    private String siteName;

    @Bean
    public {{package_base_name}}Controller helloWorld()
    {
        return new {{package_base_name}}Controller(this.siteName);
    }

    /**
     * Required to inject properties using the 'Value' annotation.
     */
    @Bean
    public static PropertySourcesPlaceholderConfigurer placeHolderConfigurer()
    {
        return new PropertySourcesPlaceholderConfigurer();
    }
}
