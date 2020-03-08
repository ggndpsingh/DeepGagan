import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct DeepGagan: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case about
        case twitter
        
        func path<T: Website>(with context: PublishingContext<T>) -> Path {
            switch self {
            case.about:
                return "/about"
            case .twitter:
                return "https://twitter.com/ggndpsingh"
            }
        }
    }

    struct ItemMetadata: WebsiteItemMetadata {

    }

    // Update these properties to configure your website:
    var url = URL(string: "https://deepgagan.com")!
    var name = "DeepGagan"
    var description = "A description of DeepGagan"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

extension Theme where Site == DeepGagan {
    static var delicious: Self {
        Theme(
            htmlFactory: DeepGaganHTMLFactory(),
            resourcePaths: ["Resources/Theme/styles.css", "Resources/Media/mainIcon.png"]
        )
    }

    private struct DeepGaganHTMLFactory: HTMLFactory {
        func makeIndexHTML(for index: Index, context: PublishingContext<DeepGagan>) throws -> HTML {
            HTML(
                .head(for: index, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .wrapper(
                        .itemsList(for: context.allItems(
                            sortedBy: \.date)
                        ),
                        .p(
                            "This will take around ",
                            "60",
                            "minutes to prepare"
                        ),
                        .contentBody("body")
                    )
                )
            )
        }
        
        func makeSectionHTML(for section: Section<DeepGagan>, context: PublishingContext<DeepGagan>) throws -> HTML {
            HTML(
                .body(
                    .p(
                        "This will take around ",
                        "60",
                        "minutes to prepare"
                    ),
                    .contentBody("body")
                )
            )
        }
        
        func makeItemHTML(for item: Item<DeepGagan>, context: PublishingContext<DeepGagan>) throws -> HTML {
            HTML(
                .body(
                    .p(
                        "This will take around ",
                        "60",
                        "minutes to prepare"
                    ),
                    .contentBody("body")
                )
            )
        }
        
        func makePageHTML(for page: Page, context: PublishingContext<DeepGagan>) throws -> HTML {
            HTML(
                .body(
                    .p(
                        "This will take around ",
                        "60",
                        "minutes to prepare"
                    ),
                    .contentBody("body")
                )
            )
        }
        
        func makeTagListHTML(for page: TagListPage, context: PublishingContext<DeepGagan>) throws -> HTML? {
            nil
        }
        
        func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<DeepGagan>) throws -> HTML? {
            nil
        }
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .wrapper(
                .a(
                    .class("site-name"),
                    .img(.src("/mainIcon.png")),
                    .href("/"), .text("The portfolio of Gagandeep Singh")
                ),
                .nav(
                    .ul(.forEach(sectionIDs) { section in
                        .li(.a(
                            .class(section == selectedSection ? "selected" : ""),
                            .href((section as! DeepGagan.SectionID).path(with: context)),
                            .text(context.sections[section].title)
                        ))
                    })
                )
            )
        )
    }
    
    static func itemsList(for items: [Item<DeepGagan>]) -> Node {
        .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .p(.text(item.description))
                ))
            }
        )
    }
}

// This will generate your website using the built-in Foundation theme:
try DeepGagan().publish(using: [
    .generateHTML(withTheme: .delicious, indentation: .spaces(4)),
    .deploy(using: .gitHub("ggndpsingh/DeepGaganLive", useSSH:  true))
])

