package line.bot.generator.pebble;

import io.pebbletemplates.pebble.extension.Filter;
import io.pebbletemplates.pebble.template.EvaluationContext;
import io.pebbletemplates.pebble.template.PebbleTemplate;
import org.openapitools.codegen.utils.StringUtils;

import java.util.Collections;
import java.util.List;
import java.util.Map;

public class CamelizeFilter implements Filter {

    @Override
    public List<String> getArgumentNames() {
        return Collections.emptyList();
    }

    @Override
    public Object apply(Object input, Map<String, Object> args, PebbleTemplate self, EvaluationContext context, int lineNumber) {
        if (!(input instanceof String)) {
            return input;
        }

        String inputStr = (String) input;
        return StringUtils.camelize(inputStr);
    }
}