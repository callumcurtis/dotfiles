final: prev: {
  sleek-grub-theme = prev.sleek-grub-theme.override {
    withStyle = "dark";
    withBanner = "Welcome to Mist";
  };
}
