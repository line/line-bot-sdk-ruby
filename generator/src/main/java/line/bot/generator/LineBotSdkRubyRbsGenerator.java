package line.bot.generator;

import java.io.File;

import org.openapitools.codegen.CodegenType;
import org.openapitools.codegen.languages.AbstractRubyCodegen;
import org.openapitools.codegen.utils.StringUtils;

// https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/java/org/openapitools/codegen/languages/AbstractRubyCodegen.java
public class LineBotSdkRubyRbsGenerator extends AbstractRubyCodegen {
    public LineBotSdkRubyRbsGenerator() {
        super();

        this.languageSpecificPrimitives.add("bool");
        this.typeMapping.put("boolean", "bool");

        apiNameSuffix = "Client";
        embeddedTemplateDir = templateDir = "line-bot-sdk-ruby-generator";
        modelTemplateFiles.put("line-bot-sdk-ruby-rbs-generator/model.pebble", ".rbs");
        apiTemplateFiles.put("line-bot-sdk-ruby-rbs-generator/api.pebble", ".rbs");
    }

    /**
     * Configures a friendly name for the generator.  This will be used by the generator
     * to select the library with the -g flag.
     *
     * @return the friendly name for the generator
     */
    public String getName() {
        return "line-bot-sdk-ruby-rbs-generator";
    }

    /**
     * Configures the type of generator.
     *
     * @return the CodegenType for this generator
     * @see CodegenType
     */
    public CodegenType getTag() {
        return CodegenType.OTHER;
    }

    @Override
    public String apiFileFolder() {
        return outputFolder + File.separator + "api";
    }

    @Override
    public String toApiFilename(String name) {
        return StringUtils.underscore(toApiName(name));
    }

    @Override
    public String modelFileFolder() {
        return outputFolder + File.separator + "model";
    }

    @Override
    public String toModelFilename(String name) {
        return StringUtils.underscore(name);
    }

    @Override
    public void processOpts() {
        super.processOpts();
        additionalProperties.put("typeMapping", this.typeMapping);
    }
}
