import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct DeepGagan: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case apps
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://deepgagan.com")!
    var name = "DeepGagan"
    var description = "A description of DeepGagan"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try DeepGagan().publish(withTheme: .foundation)
