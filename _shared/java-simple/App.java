{{java_copyright}}
package {{reversed_domain}};

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

final class Container
{
    public Container()
    {
    }

    public void addName(String name)
    {
        _names.add(name);
    }

    public List<String> names()
    {
        return _namesImmutable;
    }

    private final ArrayList<String> _names = new ArrayList<String>();
    private final List<String> _namesImmutable = Collections.unmodifiableList(_names);
}

/**
 * App class
 */
public final class App
{
    public static void main(String[] args)
    {
        for (final String arg : args)
        {
            System.out.println("arg=" + arg);
        }

        System.out.println("Hello from {{project_name}}");

        final Container items = new Container();
        items.addName("One");
        items.addName("Two");
        items.addName("Three");

        for (final String name : items.names())
        {
            System.out.println("name=" + name);
        }
    }
}
