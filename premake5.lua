project "GLFW"
    kind "StaticLib"     -- or SharedLib if you need DLL
    language "C"
    staticruntime "On"

    targetdir ("bin/GLFW/%{cfg.buildcfg}")
    objdir ("bin-int/GLFW/%{cfg.buildcfg}")

    includedirs {
        "include"
    }

    --
    -- Common GLFW sources
    --
    files {
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/vulkan.c",
        "src/window.c",
        "src/platform.c",
        "src/egl_context.c",
        "src/osmesa_context.c",

        -- NULL platform backend (required even on Win32)
        "src/null_init.c",
        "src/null_monitor.c",
        "src/null_window.c",
        "src/null_joystick.c"
    }

    --
    -- WINDOWS (WIN32)
    --
    filter "system:windows"
        defines { "_GLFW_WIN32", "_CRT_SECURE_NO_WARNINGS" }

        files {
            "src/win32_init.c",
            "src/win32_joystick.c",
            "src/win32_monitor.c",
            "src/win32_time.c",
            "src/win32_thread.c",
            "src/win32_window.c",
            "src/wgl_context.c",
            "src/win32_module.c"   -- REQUIRED for module loading
        }

        links { "gdi32", "user32", "shell32" }

    --
    -- LINUX (X11)
    --
    filter "system:linux"
        defines { "_GLFW_X11" }

        files {
            "src/x11_init.c",
            "src/x11_monitor.c",
            "src/x11_window.c",
            "src/xkb_unicode.c",
            "src/posix_time.c",
            "src/posix_thread.c",
            "src/glx_context.c",
            "src/egl_context.c",
            "src/osmesa_context.c",
            "src/linux_joystick.c",
            "src/posix_module.c",
            "src/posix_poll.c"
        }

        links { "X11", "Xrandr", "Xi", "Xcursor", "Xinerama", "pthread", "dl", "m" }

    --
    -- MACOS (COCOA)
    --
    filter "system:macosx"
        defines { "_GLFW_COCOA" }

        files {
            "src/cocoa_init.m",
            "src/cocoa_monitor.m",
            "src/cocoa_window.m",
            "src/cocoa_joystick.m",
            "src/nsgl_context.m",
            "src/posix_thread.c",
            "src/posix_time.c"
        }

        linkoptions {
            "-framework Cocoa",
            "-framework IOKit",
            "-framework CoreFoundation"
        }

    --
    -- DEBUG
    --
    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    --
    -- RELEASE
    --
    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

    --
    -- DIST
    --
    filter "configurations:Dist"
        defines { "NDEBUG" }
        optimize "Full"
        symbols "Off"
