import os
import uuid

def generate_id():
    return uuid.uuid4().hex[:24].upper()

def main():
    os.makedirs("FreeFire.xcodeproj/xcshareddata/xcschemes", exist_ok=True)
    
    # Collect all swift files in FreeFire/ relative to FreeFire/
    swift_files = []
    base_dir = "FreeFire"
    for root, dirs, files in os.walk(base_dir):
        for f in files:
            if f.endswith(".swift"):
                rel_path = os.path.relpath(os.path.join(root, f), base_dir).replace("\\", "/")
                swift_files.append((f, rel_path))
                
    print(f"Found {len(swift_files)} Swift source files.")

    # Unique IDs
    proj_id = generate_id()
    main_group_id = generate_id()
    products_group_id = generate_id()
    ff_group_id = generate_id()
    
    target_id = generate_id()
    sources_phase_id = generate_id()
    resources_phase_id = generate_id()
    frameworks_phase_id = generate_id()
    
    product_file_id = generate_id()
    infoplist_file_id = generate_id()
    assets_file_id = generate_id()
    assets_build_id = generate_id()
    
    proj_config_list_id = generate_id()
    proj_debug_config_id = generate_id()
    proj_release_config_id = generate_id()
    
    target_config_list_id = generate_id()
    target_debug_config_id = generate_id()
    target_release_config_id = generate_id()
    
    # Assign IDs to swift files
    file_entries = {}
    for filename, filepath in swift_files:
        f_id = generate_id()
        b_id = generate_id()
        file_entries[filepath] = {
            "name": filename,
            "path": filepath,
            "file_id": f_id,
            "build_id": b_id
        }

    pbx = []
    pbx.append("// !$*UTF8*$!")
    pbx.append("{")
    pbx.append("\tarchiveVersion = 1;")
    pbx.append("\tclasses = {")
    pbx.append("\t};")
    pbx.append("\tobjectVersion = 54;")
    pbx.append("\tobjects = {")
    
    # PBXBuildFile
    pbx.append("\n/* Begin PBXBuildFile section */")
    pbx.append(f"\t\t{assets_build_id} /* Assets.xcassets in Resources */ = {{isa = PBXBuildFile; fileRef = {assets_file_id} /* Assets.xcassets */; }};")
    for f in file_entries.values():
        pbx.append(f"\t\t{f['build_id']} /* {f['name']} in Sources */ = {{isa = PBXBuildFile; fileRef = {f['file_id']} /* {f['name']} */; }};")
    pbx.append("/* End PBXBuildFile section */")
    
    # PBXFileReference
    pbx.append("\n/* Begin PBXFileReference section */")
    pbx.append(f"\t\t{product_file_id} /* FreeFire.app */ = {{isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = FreeFire.app; sourceTree = BUILT_PRODUCTS_DIR; }};")
    pbx.append(f"\t\t{infoplist_file_id} /* Info.plist */ = {{isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = \"<group>\"; }};")
    pbx.append(f"\t\t{assets_file_id} /* Assets.xcassets */ = {{isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Resources/Assets.xcassets; sourceTree = \"<group>\"; }};")
    for f in file_entries.values():
        pbx.append(f"\t\t{f['file_id']} /* {f['name']} */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = \"{f['path']}\"; sourceTree = \"<group>\"; }};")
    pbx.append("/* End PBXFileReference section */")
    
    # PBXFrameworksBuildPhase
    pbx.append("\n/* Begin PBXFrameworksBuildPhase section */")
    pbx.append(f"\t\t{frameworks_phase_id} /* Frameworks */ = {{")
    pbx.append("\t\t\tisa = PBXFrameworksBuildPhase;")
    pbx.append("\t\t\tbuildActionMask = 2147483647;")
    pbx.append("\t\t\tfiles = (")
    pbx.append("\t\t\t);")
    pbx.append("\t\t\trunOnlyForDeploymentPostprocessing = 0;")
    pbx.append("\t\t};")
    pbx.append("/* End PBXFrameworksBuildPhase section */")
    
    # PBXGroup
    pbx.append("\n/* Begin PBXGroup section */")
    pbx.append(f"\t\t{main_group_id} = {{")
    pbx.append("\t\t\tisa = PBXGroup;")
    pbx.append("\t\t\tchildren = (")
    pbx.append(f"\t\t\t\t{ff_group_id} /* FreeFire */,")
    pbx.append(f"\t\t\t\t{products_group_id} /* Products */,")
    pbx.append("\t\t\t);")
    pbx.append("\t\t\tsourceTree = \"<group>\";")
    pbx.append("\t\t};")
    
    # Products Group
    pbx.append(f"\t\t{products_group_id} /* Products */ = {{")
    pbx.append("\t\t\tisa = PBXGroup;")
    pbx.append("\t\t\tchildren = (")
    pbx.append(f"\t\t\t\t{product_file_id} /* FreeFire.app */,")
    pbx.append("\t\t\t);")
    pbx.append("\t\t\tname = Products;")
    pbx.append("\t\t\tsourceTree = \"<group>\";")
    pbx.append("\t\t};")
    
    # FreeFire Group
    ff_children = [
        f"{infoplist_file_id} /* Info.plist */",
        f"{assets_file_id} /* Assets.xcassets */"
    ]
    for f in file_entries.values():
        ff_children.append(f"{f['file_id']} /* {f['name']} */")
        
    pbx.append(f"\t\t{ff_group_id} /* FreeFire */ = {{")
    pbx.append("\t\t\tisa = PBXGroup;")
    pbx.append("\t\t\tchildren = (")
    for child in ff_children:
        pbx.append(f"\t\t\t\t{child},")
    pbx.append("\t\t\t);")
    pbx.append("\t\t\tpath = FreeFire;")
    pbx.append("\t\t\tsourceTree = \"<group>\";")
    pbx.append("\t\t};")
    pbx.append("/* End PBXGroup section */")
    
    # PBXNativeTarget
    pbx.append("\n/* Begin PBXNativeTarget section */")
    pbx.append(f"\t\t{target_id} /* FreeFire */ = {{")
    pbx.append("\t\t\tisa = PBXNativeTarget;")
    pbx.append(f"\t\t\tbuildConfigurationList = {target_config_list_id} /* Build configuration list for PBXNativeTarget \"FreeFire\" */;")
    pbx.append("\t\t\tbuildPhases = (")
    pbx.append(f"\t\t\t\t{sources_phase_id} /* Sources */,")
    pbx.append(f"\t\t\t\t{frameworks_phase_id} /* Frameworks */,")
    pbx.append(f"\t\t\t\t{resources_phase_id} /* Resources */,")
    pbx.append("\t\t\t);")
    pbx.append("\t\t\tbuildRules = (")
    pbx.append("\t\t\t);")
    pbx.append("\t\t\tdependencies = (")
    pbx.append("\t\t\t);")
    pbx.append("\t\t\tname = FreeFire;")
    pbx.append("\t\t\tproductName = FreeFire;")
    pbx.append(f"\t\t\tproductReference = {product_file_id} /* FreeFire.app */;")
    pbx.append("\t\t\tproductType = \"com.apple.product-type.application\";")
    pbx.append("\t\t};")
    pbx.append("/* End PBXNativeTarget section */")
    
    # PBXProject
    pbx.append("\n/* Begin PBXProject section */")
    pbx.append(f"\t\t{proj_id} /* Project object */ = {{")
    pbx.append("\t\t\tisa = PBXProject;")
    pbx.append("\t\t\tattributes = {")
    pbx.append("\t\t\t\tBuildIndependentTargetsInParallel = 1;")
    pbx.append("\t\t\t\tLastSwiftUpdateCheck = 1500;")
    pbx.append("\t\t\t\tLastUpgradeCheck = 1500;")
    pbx.append("\t\t\t\tTargetAttributes = {")
    pbx.append(f"\t\t\t\t\t{target_id} = {{")
    pbx.append("\t\t\t\t\t\tCreatedOnToolsVersion = 15.0;")
    pbx.append("\t\t\t\t\t};")
    pbx.append("\t\t\t\t};")
    pbx.append("\t\t\t};")
    pbx.append(f"\t\t\tbuildConfigurationList = {proj_config_list_id} /* Build configuration list for PBXProject \"FreeFire\" */;")
    pbx.append("\t\t\tcompatibilityVersion = \"Xcode 14.0\";")
    pbx.append("\t\t\tdevelopmentRegion = en;")
    pbx.append("\t\t\thasScannedForEncodings = 0;")
    pbx.append("\t\t\tknownRegions = (")
    pbx.append("\t\t\t\ten,")
    pbx.append("\t\t\t\tBase,")
    pbx.append("\t\t\t);")
    pbx.append(f"\t\t\tmainGroup = {main_group_id};")
    pbx.append(f"\t\t\tproductRefGroup = {products_group_id} /* Products */;")
    pbx.append("\t\t\tprojectDirPath = \"\";")
    pbx.append("\t\t\tprojectRoot = \"\";")
    pbx.append("\t\t\ttargets = (")
    pbx.append(f"\t\t\t\t{target_id} /* FreeFire */,")
    pbx.append("\t\t\t);")
    pbx.append("\t\t};")
    pbx.append("/* End PBXProject section */")
    
    # PBXResourcesBuildPhase
    pbx.append("\n/* Begin PBXResourcesBuildPhase section */")
    pbx.append(f"\t\t{resources_phase_id} /* Resources */ = {{")
    pbx.append("\t\t\tisa = PBXResourcesBuildPhase;")
    pbx.append("\t\t\tbuildActionMask = 2147483647;")
    pbx.append("\t\t\tfiles = (")
    pbx.append(f"\t\t\t\t{assets_build_id} /* Assets.xcassets in Resources */,")
    pbx.append("\t\t\t);")
    pbx.append("\t\t\trunOnlyForDeploymentPostprocessing = 0;")
    pbx.append("\t\t};")
    pbx.append("/* End PBXResourcesBuildPhase section */")
    
    # PBXSourcesBuildPhase
    pbx.append("\n/* Begin PBXSourcesBuildPhase section */")
    pbx.append(f"\t\t{sources_phase_id} /* Sources */ = {{")
    pbx.append("\t\t\tisa = PBXSourcesBuildPhase;")
    pbx.append("\t\t\tbuildActionMask = 2147483647;")
    pbx.append("\t\t\tfiles = (")
    for f in file_entries.values():
        pbx.append(f"\t\t\t\t{f['build_id']} /* {f['name']} in Sources */,")
    pbx.append("\t\t\t);")
    pbx.append("\t\t\trunOnlyForDeploymentPostprocessing = 0;")
    pbx.append("\t\t};")
    pbx.append("/* End PBXSourcesBuildPhase section */")
    
    # XCBuildConfiguration
    pbx.append("\n/* Begin XCBuildConfiguration section */")
    # Proj Debug
    pbx.append(f"\t\t{proj_debug_config_id} /* Debug */ = {{")
    pbx.append("\t\t\tisa = XCBuildConfiguration;")
    pbx.append("\t\t\tbuildSettings = {")
    pbx.append("\t\t\t\tALWAYS_SEARCH_USER_PATHS = NO;")
    pbx.append("\t\t\t\tCLANG_ANALYZER_NONNULL = YES;")
    pbx.append("\t\t\t\tCLANG_ENABLE_MODULES = YES;")
    pbx.append("\t\t\t\tCLANG_ENABLE_OBJC_ARC = YES;")
    pbx.append("\t\t\t\tDEBUG_INFORMATION_FORMAT = dwarf;")
    pbx.append("\t\t\t\tENABLE_TESTABILITY = YES;")
    pbx.append("\t\t\t\tGCC_DYNAMIC_NO_PIC = NO;")
    pbx.append("\t\t\t\tGCC_OPTIMIZATION_LEVEL = 0;")
    pbx.append("\t\t\t\tGCC_PREPROCESSOR_DEFINITIONS = (")
    pbx.append("\t\t\t\t\t\"DEBUG=1\",")
    pbx.append("\t\t\t\t\t\"$(inherited)\",")
    pbx.append("\t\t\t\t);")
    pbx.append("\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 15.0;")
    pbx.append("\t\t\t\tMTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;")
    pbx.append("\t\t\t\tMTL_FAST_MATH = YES;")
    pbx.append("\t\t\t\tONLY_ACTIVE_ARCH = YES;")
    pbx.append("\t\t\t\tSDKROOT = iphoneos;")
    pbx.append("\t\t\t\tSWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;")
    pbx.append("\t\t\t\tSWIFT_OPTIMIZATION_LEVEL = \"-Onone\";")
    pbx.append("\t\t\t};")
    pbx.append("\t\t\tname = Debug;")
    pbx.append("\t\t};")
    
    # Proj Release
    pbx.append(f"\t\t{proj_release_config_id} /* Release */ = {{")
    pbx.append("\t\t\tisa = XCBuildConfiguration;")
    pbx.append("\t\t\tbuildSettings = {")
    pbx.append("\t\t\t\tALWAYS_SEARCH_USER_PATHS = NO;")
    pbx.append("\t\t\t\tCLANG_ANALYZER_NONNULL = YES;")
    pbx.append("\t\t\t\tCLANG_ENABLE_MODULES = YES;")
    pbx.append("\t\t\t\tCLANG_ENABLE_OBJC_ARC = YES;")
    pbx.append("\t\t\t\tCOPY_PHASE_STRIP = NO;")
    pbx.append("\t\t\t\tDEBUG_INFORMATION_FORMAT = \"dwarf-with-dsym\";")
    pbx.append("\t\t\t\tENABLE_NS_ASSERTIONS = NO;")
    pbx.append("\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 15.0;")
    pbx.append("\t\t\t\tMTL_ENABLE_DEBUG_INFO = NO;")
    pbx.append("\t\t\t\tMTL_FAST_MATH = YES;")
    pbx.append("\t\t\t\tSDKROOT = iphoneos;")
    pbx.append("\t\t\t\tSWIFT_COMPILATION_MODE = wholemodule;")
    pbx.append("\t\t\t\tSWIFT_OPTIMIZATION_LEVEL = \"-O\";")
    pbx.append("\t\t\t\tVALIDATE_PRODUCT = YES;")
    pbx.append("\t\t\t};")
    pbx.append("\t\t\tname = Release;")
    pbx.append("\t\t};")
    
    # Target Debug
    pbx.append(f"\t\t{target_debug_config_id} /* Debug */ = {{")
    pbx.append("\t\t\tisa = XCBuildConfiguration;")
    pbx.append("\t\t\tbuildSettings = {")
    pbx.append("\t\t\t\tASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;")
    pbx.append("\t\t\t\tASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;")
    pbx.append("\t\t\t\tCODE_SIGNING_ALLOWED = NO;")
    pbx.append("\t\t\t\tCODE_SIGNING_REQUIRED = NO;")
    pbx.append("\t\t\t\tCODE_SIGN_IDENTITY = \"\";")
    pbx.append("\t\t\t\tCODE_SIGN_STYLE = Manual;")
    pbx.append("\t\t\t\tCURRENT_PROJECT_VERSION = 1;")
    pbx.append("\t\t\t\tDEVELOPMENT_TEAM = \"\";")
    pbx.append("\t\t\t\tENABLE_PREVIEWS = YES;")
    pbx.append("\t\t\t\tGENERATE_INFOPLIST_FILE = NO;")
    pbx.append("\t\t\t\tINFOPLIST_FILE = FreeFire/Info.plist;")
    pbx.append("\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 15.0;")
    pbx.append("\t\t\t\tLD_RUNPATH_SEARCH_PATHS = (")
    pbx.append("\t\t\t\t\t\"$(inherited)\",")
    pbx.append("\t\t\t\t\t\"@executable_path/Frameworks\",")
    pbx.append("\t\t\t\t);")
    pbx.append("\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = com.purorodriguez.freefire;")
    pbx.append("\t\t\t\tPRODUCT_NAME = \"$(TARGET_NAME)\";")
    pbx.append("\t\t\t\tSWIFT_EMIT_LOC_STRINGS = YES;")
    pbx.append("\t\t\t\tSWIFT_VERSION = 5.0;")
    pbx.append("\t\t\t\tTARGETED_DEVICE_FAMILY = \"1,2\";")
    pbx.append("\t\t\t};")
    pbx.append("\t\t\tname = Debug;")
    pbx.append("\t\t};")
    
    # Target Release
    pbx.append(f"\t\t{target_release_config_id} /* Release */ = {{")
    pbx.append("\t\t\tisa = XCBuildConfiguration;")
    pbx.append("\t\t\tbuildSettings = {")
    pbx.append("\t\t\t\tASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;")
    pbx.append("\t\t\t\tASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;")
    pbx.append("\t\t\t\tCODE_SIGNING_ALLOWED = NO;")
    pbx.append("\t\t\t\tCODE_SIGNING_REQUIRED = NO;")
    pbx.append("\t\t\t\tCODE_SIGN_IDENTITY = \"\";")
    pbx.append("\t\t\t\tCODE_SIGN_STYLE = Manual;")
    pbx.append("\t\t\t\tCURRENT_PROJECT_VERSION = 1;")
    pbx.append("\t\t\t\tDEVELOPMENT_TEAM = \"\";")
    pbx.append("\t\t\t\tENABLE_PREVIEWS = YES;")
    pbx.append("\t\t\t\tGENERATE_INFOPLIST_FILE = NO;")
    pbx.append("\t\t\t\tINFOPLIST_FILE = FreeFire/Info.plist;")
    pbx.append("\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 15.0;")
    pbx.append("\t\t\t\tLD_RUNPATH_SEARCH_PATHS = (")
    pbx.append("\t\t\t\t\t\"$(inherited)\",")
    pbx.append("\t\t\t\t\t\"@executable_path/Frameworks\",")
    pbx.append("\t\t\t\t);")
    pbx.append("\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = com.purorodriguez.freefire;")
    pbx.append("\t\t\t\tPRODUCT_NAME = \"$(TARGET_NAME)\";")
    pbx.append("\t\t\t\tSWIFT_EMIT_LOC_STRINGS = YES;")
    pbx.append("\t\t\t\tSWIFT_VERSION = 5.0;")
    pbx.append("\t\t\t\tTARGETED_DEVICE_FAMILY = \"1,2\";")
    pbx.append("\t\t\t};")
    pbx.append("\t\t\tname = Release;")
    pbx.append("\t\t};")
    pbx.append("/* End XCBuildConfiguration section */")
    
    # XCConfigurationList
    pbx.append("\n/* Begin XCConfigurationList section */")
    pbx.append(f"\t\t{proj_config_list_id} /* Build configuration list for PBXProject \"FreeFire\" */ = {{")
    pbx.append("\t\t\tisa = XCConfigurationList;")
    pbx.append("\t\t\tbuildConfigurations = (")
    pbx.append(f"\t\t\t\t{proj_debug_config_id} /* Debug */,")
    pbx.append(f"\t\t\t\t{proj_release_config_id} /* Release */,")
    pbx.append("\t\t\t);")
    pbx.append("\t\t\tdefaultConfigurationIsVisible = 0;")
    pbx.append("\t\t\tdefaultConfigurationName = Release;")
    pbx.append("\t\t};")
    
    pbx.append(f"\t\t{target_config_list_id} /* Build configuration list for PBXNativeTarget \"FreeFire\" */ = {{")
    pbx.append("\t\t\tisa = XCConfigurationList;")
    pbx.append("\t\t\tbuildConfigurations = (")
    pbx.append(f"\t\t\t\t{target_debug_config_id} /* Debug */,")
    pbx.append(f"\t\t\t\t{target_release_config_id} /* Release */,")
    pbx.append("\t\t\t);")
    pbx.append("\t\t\tdefaultConfigurationIsVisible = 0;")
    pbx.append("\t\t\tdefaultConfigurationName = Release;")
    pbx.append("\t\t};")
    pbx.append("/* End XCConfigurationList section */")
    
    pbx.append("\t};")
    pbx.append(f"\trootObject = {proj_id} /* Project object */;")
    pbx.append("}")
    
    with open("FreeFire.xcodeproj/project.pbxproj", "w", encoding="utf-8") as f:
        f.write("\n".join(pbx) + "\n")
        
    print("Generated FreeFire.xcodeproj/project.pbxproj successfully!")

    # Generate Shared Scheme FreeFire.xcscheme
    scheme = f"""<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "1500"
   version = "1.7">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "{target_id}"
               BuildableName = "FreeFire.app"
               BlueprintName = "FreeFire"
               ReferencedContainer = "container:FreeFire.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      shouldUseLaunchSchemeArgsEnv = "YES">
      <Testables>
      </Testables>
   </TestAction>
   <LaunchAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      launchStyle = "0"
      useCustomWorkingDirectory = "NO"
      ignoresPersistentStateOnLaunch = "NO"
      debugDocumentVersioning = "YES"
      debugServiceExtension = "internal"
      allowLocationSimulation = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "{target_id}"
            BuildableName = "FreeFire.app"
            BlueprintName = "FreeFire"
            ReferencedContainer = "container:FreeFire.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ProfileAction
      buildConfiguration = "Release"
      shouldUseLaunchSchemeArgsEnv = "YES"
      savedToolIdentifier = ""
      useCustomWorkingDirectory = "NO"
      debugDocumentVersioning = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "{target_id}"
            BuildableName = "FreeFire.app"
            BlueprintName = "FreeFire"
            ReferencedContainer = "container:FreeFire.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </ProfileAction>
   <AnalyzeAction
      buildConfiguration = "Debug">
   </AnalyzeAction>
   <ArchiveAction
      buildConfiguration = "Release"
      revealArchiveInOrganizer = "YES">
   </ArchiveAction>
</Scheme>
"""
    with open("FreeFire.xcodeproj/xcshareddata/xcschemes/FreeFire.xcscheme", "w", encoding="utf-8") as f:
        f.write(scheme)
    print("Generated FreeFire.xcscheme successfully!")

if __name__ == "__main__":
    main()
