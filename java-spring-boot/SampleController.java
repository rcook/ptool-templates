{{java_copyright}}
package {{reversed_domain}};
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@EnableAutoConfiguration
public final class SampleController
{
    @RequestMapping("/")
    @ResponseBody
    public String home()
    {
        return "Hello world";
    }
}
