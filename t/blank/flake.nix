{
  description = "My Flakes Templates";

  outputs = { self, ... }: {
    templates = {
      default = {
        path = ./default;
        description = "Default blank flake";
      };
    };
  };
}
