module TOGAwaken

using Sockets

# const TOG = "TheoryOfGod"
const TOGDIR = ".tog"
# const GITHUB = "https://github.com"
# const iGITHUB_USER = "1m1-github"
# const TOGINSTALLURL = GITHUB * "/" * iGITHUB_USER * "/" * string(@__MODULE__) * ".git"
# const TOGINSTALLSCRIPT = """julia -e 'using Pkg;Pkg.add(url=$TOGINSTALLURL);using $(@__MODULE__);$(@__MODULE__).awaken();Pkg.rm("$(@__MODULE__)")'"""
# const REGISTRYURL = GITHUB * "/" * iGITHUB_USER * "/" * TOGLearning.REGISTRYNAME * ".git"
# const INSTALLURL = GITHUB * "/" * iGITHUB_USER * "/" * string(@__MODULE__) * ".git"
# const JULIA_ARGS = ["--optimize=3", "--threads=auto", "--quiet", "--interactive"]

globalpath(;path=".") = joinpath(pwd(), path)
router(;path=".") = "ipc://$(globalpath(path=path))/$TOGDIR/router.ipc" # change to tcp if on separate machines
pub(;path=".") = "ipc://$(globalpath(path=path))/$TOGDIR/pub.ipc" # change to tcp if on separate machines
togobserve(;path=".") = "ipc://$(globalpath(path=path))/$TOGDIR/togobserve.ipc" # change to tcp if on separate machines
togcreate(;path=".") = "ipc://$(globalpath(path=path))/$TOGDIR/togcreate.ipc" # change to tcp if on separate machines
# const REPLPORT(path) = joinpath(globalpath(path=path), TOGDIR, "replport")
# writepid() = """write(joinpath("$TOGDIR", "pid"), string(getpid()))"""
pidfile(; path=".") = joinpath(path, TOGDIR, "pid")
readpid(; file=pidfile()) = parse(Int, read(file, String))
function awaken(; path=".")
    isawake(path=path) && error("TOGgod at $path is already awake.")
    writepid(path=path)
end
writepid(; path=".") = write(pidfile(path=path), string(getpid()))
sleep = rmpid
function rmpid(; path=".")
    file = pidfile(path=path)
    isfile(file) && rm(file)
end
function isawake(; path=".")
    file = pidfile(path=path)
    isfile(file) || return false
    pid = readpid(file=file)
    success(`kill -0 $pid`)
end
function openport()
    server = listen(0)
    port = getsockname(server)[2]
    close(server)
    port
end

# function awaken()
#     mkdir(TOG)
#     # && cd(TOG)
#     julia(
#         dir=TOG,
#         code="""using Pkg;Pkg.add(url="$TOGINSTALLURL");using $(@__MODULE__);$(@__MODULE__).awakenGOD()"""
#     )
# end

# function awakenGOD()
#     write("c1","1")
#     write(joinpath(TOGDIR, "pid"), string(getpid()))
#     replport=openport()
#     write(joinpath(TOGDIR, "replport"), string(replport))
#     @show "awakenGOD", pwd()
#     addregistry()
#     Pkg.add(["TOGOmega"])
#     write("c2",string(@__MODULE__))
#     # write("c22",string(DEPOT_PATH))
#     # Pkg.Apps.add(path=joinpath(DEPOT_PATH[2], "dev", string(@__MODULE__)))
#     # write("c3","installed")
#     # @show "installed:", joinpath(pwd(), TOGDIR, "julia", "bin", "tog")
#     # awakenGOD(["i"]) # Dona, Anna, Janet
#     # awakenGOD()
#     # eval(:(using TOGOmega))
#     write("c3","installed")
#     TOGOmega.awaken(router=ROUTERLOCATION(pwd()), pub=PUBLOCATION(pwd()), tog=TOGLOCATION(pwd()), replport=replport)
# end
# # function awakenGOD(gods)
# # TOGOmega.awaken(gods)
# # end

# function awakengodinit(; path, pkgs, router, pub, tog)
#     addregistry()
#     Pkg.add(["TOGgod", pkgs...])
#     awakengodinner(path=path, router=router, pub=pub, tog=tog)
# end
# function awakengodinner(; path, router, pub, tog)
#     write(joinpath(TOGDIR, "pid"), string(getpid()))
#     # eval(:(using TOGgod))
#     TOGgod.awaken(name=basename(path), router=router, pub=pub, tog=tog, replport=openport())
# end
# function isawake(; path)
#     pidfile = joinpath(path, TOGDIR, "pid")
#     !isfile(pidfile) && return false
#     pid = read(pidfile)
#     success(`kill -0 $pid`)
# end
# doesgodexist(; path) = isdir(path) && isdir(joinpath(path, TOGDIR))
# function awakengod(; path, router, pub, tog, pkgs=[])
#     isawake(path=path) && error("god $name already awake.")
#     doesgodexist(path=path) && julia(
#         dir=path,
#         code="""using $(@__MODULE__);$(@__MODULE__).awakengodinner(path=$path, router=router, pub=pub, tog=tog)"""
#     )
#     julia(
#         dir=path,
#         code="""using Pkg;Pkg.add(url="$(@__MODULE__)");using $(@__MODULE__);$(@__MODULE__).awakengodinit(name=$name, router=router, pub=pub, tog=tog, pkgs=$pkgs)"""
#     )
# end

# function parse_commandline()
#     s = ArgParseSettings()
#     @add_arg_table s begin
#         "--universe", "-u"
#         arg_type = String
#         default = "."
#         "--god", "-g"
#         arg_type = String
#         default = "i"
#         # "--stop-universe"
#         # arg_type = Bool
#         # default = false
#         # "--stop-god"
#         # arg_type = Bool
#         # default = false
#         # "--update"
#         # action = :store_true
#     end
#     return parse_args(s)
# end
# checkdir() = (basename(pwd()) == TOG && isdir(TOGDIR)) || error("Run tog in a $TOG folder. Run $TOGINSTALLSCRIPT to create a new $TOG folder.")

# const REGISTRYADD = """
# using Pkg
# isfile(joinpath(DEPOT_PATH[1], "registries", "General.toml")) || Pkg.Registry.add("General")
# isfile(joinpath(DEPOT_PATH[1], "registries", "$(TOGLearning.REGISTRYNAME)", "Registry.toml")) || Pkg.Registry.add(url="$REGISTRYURL")
# """
# function (@main)(args)
#     config = parse_commandline()
    # if config["update"]
    #     for pkg = readdir(joinpath(DEPOT_PATH[1], "dev"), join=true)
    #         isdir(pkg) || continue
    #         TOGLearning.isdirty(path=pkg) || continue
    #         TOGLearning.updatepkg(name=basename(pkg))
    #     end
    #     return Pkg.update()
    # end
    # universepidfile = pidfile(path=config["universe"])
    # godpidfile = pidfile(path=config["god"])
    # universerunning = isfile(universepidfile)
    # godrunning = isfile(godpidfile)
    # if config["stop-universe"] && universerunning
    #     pid = readpid(file=universepidfile)
    #     rm(universepidfile)
    #     return run(`kill -9 $pid`)
    # elseif config["stop-god"] && godrunning
    #     pid = readpid(file=godpidfile)
    #     rm(godpidfile)
    #     return run(`kill -9 $pid`)
    # end
    # @show universerunning
    # router = ROUTERLOCATION(config["universe"])
    # pub = PUBLOCATION(config["universe"])
    # tog = TOGLOCATION(config["universe"])
    # if !universerunning
    #     if !isdir(config["universe"])
    #         mkdir(config["universe"])
    #     end
        # replport = openport()
        # @show replport
        # julia(
        #     dir=".",
        #     code="""
        #     $(writepid())
        #     $REGISTRYADD
        #     Pkg.add("TOGOmega")
        #     Pkg.update()
        #     using TOGOmega
        #     TOGOmega.awaken(router="$router",pub="$pub",tog="$tog",replport=$replport)
        #     wait(Condition())
        #     """, wait=false
        # )
        # connect_repl(replport)
    # end
    # @show godrunning
    # if !godrunning
    #     if !isdir(config["god"])
    #         mkdir(config["god"])
    #     end
    #     name = basename(config["god"])
    #     replport = openport()
    #     @show replport
    #     julia(
    #         dir=config["god"],
    #         code="""
    #         $(writepid())
    #         $REGISTRYADD
    #         Pkg.add(["TOGgod", "$name"])
    #         Pkg.update()
    #         using TOGgod
    #         TOGgod.awaken(name="$name",router="$router",pub="$pub",tog="$tog",replport=$replport)
    #         """, wait=true
    #     )
    #     # connect_repl(replport)
    # end

    # DEBUG - in general maybe TOG is elsewhere
    # while !isfile(REPLPORT(config["universe"]))
    #     sleep(1)
    # end
    # universereplport = read(REPLPORT(config["universe"]), Int)
    # @show universereplport
    # connect_repl(universereplport)

    # checkdir()
    # julia(
    #     dir=".",
    #     code="""using $(@__MODULE__);$(@__MODULE__).awakenGOD($(config["names"]))"""
    # )
    0
# end

end

# args = if Sys.isapple()
#     profile = joinpath(name, ".sb")
#     write(
#         profile,
#         """
#         (version 1)
#         (allow default)
#         (deny file-write*)
#         (allow file-write* (subpath "$name"))
#         """
#     )
#     [
#         "sandbox-exec",
#         "-f",
#         profile,
#         "sh",
#         "-c",
#     ]
# elseif Sys.islinux()
#     [
#         "bwrap",
#         "--ro-bind", "/", "/",
#         "--bind", name, name,
#         "--proc", "/proc",
#         "--dev", "/dev",
#         "--die-with-parent",
#     ]
# else
#     error("Only MacOS and Linux")
# end
# append!(args, julia_args)
# run(Cmd(args))
# try
#     @show Cmd(julia_args)
#     run(Cmd(julia_args)) # todo use sandbox, add wait = false
# catch e
#     @show e
#     throw(e)
# end
# rm(".sb")
# # rm(joinpath(name, ".sb"))
# cd("..")
# env JULIA_DEPOT_PATH=/Users/1m1/Documents/TheoryOfGod/.tog/julia:/Users/1m1/.julia JULIA_PROJECT=/Users/1m1/Documents/TheoryOfGod/.tog JULIA_PKG_USE_CLI_GIT=true julia --optimize --threads=auto --quiet --interactive
# env JULIA_DEPOT_PATH=/Users/1m1/Documents/TheoryOfGod/i/.tog/julia:/Users/1m1/Documents/TheoryOfGod/.tog/julia:/Users/1m1/.julia JULIA_PROJECT=/Users/1m1/Documents/TheoryOfGod/i/.tog JULIA_PKG_USE_CLI_GIT=true julia --optimize --threads=auto --quiet --interactive
# env JULIA_DEPOT_PATH=/Users/1m1/Documents/TheoryOfGod/Dona/.tog/julia:/Users/1m1/Documents/TheoryOfGod/.tog/julia:/Users/1m1/.julia JULIA_PROJECT=/Users/1m1/Documents/TheoryOfGod/Dona/.tog JULIA_PKG_USE_CLI_GIT=true julia --optimize --threads=auto --quiet --interactive
# env JULIA_DEPOT_PATH=/Users/1m1/Documents/TheoryOfGod/Anna/.tog/julia:/Users/1m1/Documents/TheoryOfGod/.tog/julia:/Users/1m1/.julia JULIA_PROJECT=/Users/1m1/Documents/TheoryOfGod/Anna/.tog JULIA_PKG_USE_CLI_GIT=true julia --optimize --threads=auto --quiet --interactive

# env JULIA_DEPOT_PATH=.tog/julia:/Users/1m1/.julia:/Users/1m1/.julia/juliaup/julia-1.12.6+0.aarch64.apple.darwin14/Julia-1.12.app/Contents/Resources/julia/local/share/julia:/Users/1m1/.julia/juliaup/julia-1.12.6+0.aarch64.apple.darwin14/Julia-1.12.app/Contents/Resources/julia/share/julia JULIA_PROJECT=.tog julia
