import os
import subprocess
import sys

def run_command(command):
    """Run a shell command and handle its output."""
    print(f"Running command: {command}")
    proc = subprocess.run(command, shell=True, text=True, capture_output=True)

    if proc.stdout:
        print("\n\nSTDOUT:\n\n")
        print(proc.stdout)

    if proc.stderr:
        print("\n\nSTDERR:\n\n")
        print(proc.stderr)

    if proc.returncode != 0:
        print(f"\n\nCommand '{command}' returned non-zero exit status {proc.returncode}.")
        sys.exit(1)

    return proc.stdout.strip()

def generate_client(source_yaml, generator_name, output_base_path):
    """Generate client code for a given YAML file and generator."""
    package_name = source_yaml.replace('.yml', '').replace('-', '_')
    output_path = os.path.join(output_base_path, package_name)

    run_command(f'rm -rf {output_path}/')

    command = (
        f"java -cp ./generator/target/line-bot-sdk-ruby-generator-1.0.0.jar "
        f"org.openapitools.codegen.OpenAPIGenerator generate "
        f"-e pebble "
        f"-g {generator_name} "
        f"--enable-post-process-file "
        f"-o {output_path} "
        f"-i line-openapi/{source_yaml} "
        f"--additional-properties packageName={package_name}"
    )
    run_command(command)

def generate_clients():
    """Generate clients for all components."""
    components = [
        "channel-access-token.yml",
        "insight.yml",
        "liff.yml",
        "manage-audience.yml",
        "messaging-api.yml",
        "module-attach.yml",
        "module.yml",
        "shop.yml",
        "webhook.yml",
    ]

    for source_yaml in components:
        generate_client(source_yaml, "line-bot-sdk-ruby-generator", "lib/line/bot/v2")
        generate_client(source_yaml, "line-bot-sdk-ruby-rbs-generator", "sig/line/bot/v2")

    # Remove the dummy API client from the webhook component
    run_command("rm -rf lib/line/bot/v2/webhook/api")
    run_command("rm -rf sig/line/bot/v2/webhook/api")

def main():
    """Main function to package and generate clients."""
    os.chdir("generator")
    run_command('mvn package -DskipTests=true')
    os.chdir("..")

    generate_clients()

if __name__ == "__main__":
    main()
