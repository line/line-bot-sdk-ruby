package line.bot.generator.pebble;

import io.pebbletemplates.pebble.extension.AbstractExtension;
import io.pebbletemplates.pebble.extension.Filter;
import io.pebbletemplates.pebble.extension.Function;

import java.util.HashMap;
import java.util.Map;

public class MyPebbleExtension extends AbstractExtension {
    @Override
    public Map<String, Function> getFunctions() {
        final HashMap<String, Function> map = new HashMap<>();
        map.put("endpoint", new EndpointFunction());
        return map;
    }

    @Override
    public Map<String, Filter> getFilters() {
        final HashMap<String, Filter> filters = new HashMap<>();
        filters.put("camelize", new CamelizeFilter());
        filters.put("underscore", new UnderscoreFilter());
        return filters;
    }
}
