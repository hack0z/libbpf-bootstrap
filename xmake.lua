add_rules("mode.release", "mode.debug")
add_rules("platform.linux.bpf")
set_license("GPL-2.0")

add_requires("linux-tools", {configs = {bpftool = true}})
add_requires("libbpf")
if is_plat("android") then
    add_requires("ndk >=22.x", "argp-standalone")
    set_toolchains("@ndk", {sdkver = "23"})
else
    add_requires("llvm >=10.x")
    set_toolchains("@llvm")
    add_requires("linux-headers")
end

target("minimal")
    set_kind("binary")
    add_files("src/minimal*.c")
    add_packages("linux-tools", "linux-headers", "libbpf")

target("bootstrap")
    set_kind("binary")
    add_files("src/bootstrap*.c")
    add_packages("linux-tools", "linux-headers", "libbpf")
    if is_plat("android") then
        add_packages("argp-standalone")
    end

target("fentry")
    set_kind("binary")
    add_files("src/fentry*.c")
    add_packages("linux-tools", "linux-headers", "libbpf")

target("kprobe")
    set_kind("binary")
    add_files("src/kprobe*.c")
    add_packages("linux-tools", "linux-headers", "libbpf")
    if is_plat("android") then
        -- TODO we need add vmlinux.h for android
        set_default(false)
    end
