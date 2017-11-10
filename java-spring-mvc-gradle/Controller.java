{{java_copyright}}
package {{reversed_domain}}.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Basic Spring MVC controller that handles all GET requests.
 */
@Controller
@RequestMapping("/")
public final class {{package_base_name}}Controller
{
    private final String siteName;

    public {{package_base_name}}Controller(final String siteName)
    {
        this.siteName = siteName;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView helloWorld()
    {
        ModelAndView mav = new ModelAndView("index");
        mav.addObject("siteName", this.siteName);
        return mav;
    }
}
