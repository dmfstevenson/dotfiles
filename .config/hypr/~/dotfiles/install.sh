#!/usr/bin/env bash

# Script to set up dotfiles by creating symbolic links
# and ensuring necessary files/permissions.

# Variables
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
AUTOSTART_DIR="$CONFIG_DIR/autostart"

# Config directories to symlink
CONFIG_FOLDERS=(
    "hypr"
    "waybar"
    "rofi"
    "swaync"
    "ags"
    "kitty"
)

echo "🚀 Starting dotfiles setup..."

# Create necessary base directories

echo "📂 Ensuring base directories exist..."
mkdir -p "$CONFIG_DIR"
mkdir -p "$AUTOSTART_DIR"

# Symlink config folders
echo "🔗 Creating symbolic links for config directories..."
for folder in "${CONFIG_FOLDERS[@]}"; do
    source_path="$DOTFILES_DIR/.config/$folder"
    target_path="$CONFIG_DIR/$folder"

    if [ -L "$target_path" ] && [ -d "$target_path" ]; then
        echo "  ✅ Link for $folder already exists. Skipping."
    elif [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
        echo "  ⚠️  Warning: $target_path exists and is not a symlink. Please back it up or remove it first."
    elif [ ! -d "$source_path" ]; then
        echo "  ⚠️  Warning: Source $source_path does not exist. Cannot create link for $folder."
    else
        ln -s "$source_path" "$target_path"
        echo "  ✅ Symlinked $folder"
    fi
done

# Create GNOME Keyring autostart file
KEYRING_DESKTOP_FILE="$AUTOSTART_DIR/gnome-keyring-daemon.desktop"
echo "🔑 Creating GNOME Keyring autostart file..."
if [ -f "$KEYRING_DESKTOP_FILE" ]; then
    echo "  ✅ GNOME Keyring autostart file already exists. Skipping."
else
    cat << EOF > "$KEYRING_DESKTOP_FILE"
[Desktop Entry]
Type=Application
Name=GNOME Keyring
Exec=gnome-keyring-daemon --start --components=secrets,pkcs11,ssh
NoDisplay=true
X-GNOME-Autostart-enabled=true
EOF
    echo "  ✅ Created $KEYRING_DESKTOP_FILE"
fi

# Make Hyprland scripts executable
HYPR_SCRIPTS_DIR="$DOTFILES_DIR/.config/hypr/scripts"
HYPR_USERSCRIPTS_DIR="$DOTFILES_DIR/.config/hypr/UserScripts"

echo "⚙️  Making Hyprland scripts executable..."
if [ -d "$HYPR_SCRIPTS_DIR" ]; then
    find "$HYPR_SCRIPTS_DIR" -type f -name "*.sh" -exec chmod +x {} \;
    echo "  ✅ Scripts in $HYPR_SCRIPTS_DIR processed."
else
    echo "  ⚠️  Warning: $HYPR_SCRIPTS_DIR not found."
fi

if [ -d "$HYPR_USERSCRIPTS_DIR" ]; then
    find "$HYPR_USERSCRIPTS_DIR" -type f -name "*.sh" -exec chmod +x {} \;
    echo "  ✅ Scripts in $HYPR_USERSCRIPTS_DIR processed."
else
    echo "  ⚠️  Warning: $HYPR_USERSCRIPTS_DIR not found."
fi

echo "🎉 Dotfiles setup complete!"
echo "💡 Remember to commit and push your changes in ~/dotfiles to your GitHub repository." 