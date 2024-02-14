task InstallBuildDependencies {
    Install-Module PsMermaidTools, platyPS, powershell-yaml
}

task InstallTestDependencies {
    Install-Module PsMermaidTools
}

task InstallReleaseDependencies {
    Install-Module PsMermaidTools
}