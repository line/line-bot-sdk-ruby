package line.bot.generator;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.openapitools.codegen.CodegenDiscriminator;
import org.openapitools.codegen.CodegenModel;
import org.openapitools.codegen.CodegenType;
import org.openapitools.codegen.SupportingFile;
import org.openapitools.codegen.languages.AbstractRubyCodegen;
import org.openapitools.codegen.model.ModelMap;
import org.openapitools.codegen.model.ModelsMap;
import org.openapitools.codegen.utils.StringUtils;

// https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/java/org/openapitools/codegen/languages/AbstractRubyCodegen.java
public class LineBotSdkRubyGenerator extends AbstractRubyCodegen {
    public LineBotSdkRubyGenerator() {
        super();

        apiNameSuffix = "Client";
        embeddedTemplateDir = templateDir = "line-bot-sdk-ruby-generator";
        modelTemplateFiles.put("line-bot-sdk-ruby-generator/model.pebble", ".rb");
        apiTemplateFiles.put("line-bot-sdk-ruby-generator/api.pebble", ".rb");
    }

    /**
     * Configures a friendly name for the generator.  This will be used by the generator
     * to select the library with the -g flag.
     *
     * @return the friendly name for the generator
     */
    public String getName() {
        return "line-bot-sdk-ruby-generator";
    }

    /**
     * Configures the type of generator.
     *
     * @return the CodegenType for this generator
     * @see org.openapitools.codegen.CodegenType
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
        additionalProperties.put("typeMapping", typeMapping);
        supportingFiles.add(new SupportingFile("line-bot-sdk-ruby-generator/core.pebble", apiPackage().replace('.', File.separatorChar), "core.rb"));
    }

    @Override
    public Map<String, ModelsMap> postProcessAllModels(Map<String, ModelsMap> objs) {
        final Map<String, ModelsMap> result = super.postProcessAllModels(objs);

        for (ModelsMap entry : result.values()) {
            for (ModelMap mo : entry.getModels()) {
                CodegenModel cm = mo.getModel();

                if (cm.getParentModel() != null) {
                    final CodegenDiscriminator discriminator = cm.getParentModel().getDiscriminator();
                    final Optional<String> mappingNameOptional = discriminator.getMappedModels().stream().filter(
                            it -> it.getModelName().equals(cm.name)
                    ).map(CodegenDiscriminator.MappedModel::getMappingName).findFirst();
                    mappingNameOptional.ifPresent(mappingName -> {
                        final Map<String, Object> selector = new HashMap<>();
                        selector.put("propertyName", discriminator.getPropertyName());
                        selector.put("mappingName", mappingName);
                        cm.getVendorExtensions().put("x-selector", selector);
                    });
                }
            }
        }
        return result;
    }
}
