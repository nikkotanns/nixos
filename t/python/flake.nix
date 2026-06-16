{
  description = "My Flakes Templates";

  outputs = { self, ... }: {
    templates = {
      default = {
        path = ./default;
        description = "Default flake for python";
      };
      pulumi = {
        path = ./pulumi;
        description = "Default flake for pulumi";
      };
      pulumi-yandex = {
        path = ./pulumi-yandex;
        description = "Default flake for pulumi and yandex cloud";
      };
    };
  };
}
