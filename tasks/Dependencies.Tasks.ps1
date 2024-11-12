task InstallBuildDependencies {
    Install-Module PsMermaidTools, platyPS, Yayaml
}

task InstallTestDependencies {
    Install-Module PsMermaidTools
}

task InstallReleaseDependencies {
    Install-Module PsMermaidTools
}