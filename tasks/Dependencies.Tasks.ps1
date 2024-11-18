task InstallBuildDependencies {
    Install-Module PsMermaidTools, platyPS, Yayaml
}

task InstallTestDependencies {
    Install-Module PsMermaidTools, Yayaml
}

task InstallReleaseDependencies {
    Install-Module PsMermaidTools, Yayaml
}