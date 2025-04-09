// https://gist.github.com/Yu212/7c4d91cc631630b17958754fd23c357b

#import "@preview/cetz:0.3.4"

#let proof(root, margin: 3) = {
  cetz.canvas({
    import cetz.draw: *
    
    let min(..a) = {
      let a = a.pos().filter(v => v != none)
      return calc.min(..a)
    }

    let max(..a) = {
      let a = a.pos().filter(v => v != none)
      return calc.max(..a)
    }
    
    let build-node(tree, depth: 0, sibling: 0) = {
      let children = ()
      let content = none
      let label = none
      if type(tree) == array {
        content = tree.at(0)
        let children-start = 1
        while children-start < tree.len() and type(tree.at(children-start)) == int {
          children-start += 1
        }
        label = tree.slice(1, children-start).map(v => $#v$).join($,$)
        children = tree.slice(children-start).enumerate()
          .map(((n, c)) => build-node(c, depth: depth + 1, sibling: n))
      } else {
        content = tree
      }
      return (
        x: 0,
        y: depth,
        n: sibling, 
        depth: depth,
        children: children,
        label: label,
        content: content
      )
    }
    let layout-node(node, shift-x) = {
      if node.children.len() == 0 {
        node.x = shift-x
        return (node, node.x, node.x)
      } else {
        let (min-x, max-x) = (none, none)
        let (left, right) = (none, none)
        let n-children = node.children.len()
        for i in range(0, n-children) {
          let child = node.children.at(i)
          let (child-min-x, child-max-x) = (none, none)
          (child, child-min-x, child-max-x) = layout-node(child, shift-x)
          node.children.at(i) = child
          left = min(left, child.x)
          right = max(right, child.x)
          min-x = min(min-x, child-min-x)
          max-x = max(max-x, child-max-x)
          shift-x = child-max-x + margin
        }
        node.x = left + (right - left) / 2
        node.direct-min-x = left
        node.direct-max-x = right
        node.min-x = min-x
        node.max-x = max-x
        return (node, min-x, max-x)
      }
    }
    let draw-node(node) = {
      get-ctx(ctx => {
        content((), node.content)
        if node.children.len() == 0 and node.label != none {
          content((node.x, node.y + 0.5), [#node.label])
        }
      })
    }
    let draw-bar(node) = {
      let first-child = node.children.at(0)
      let last-child = node.children.at(node.children.len() - 1)
      let left-1 = node.group-name + ".west"
      let left-2 = first-child.group-name + ".west"
      let right-1 = node.group-name + ".east"
      let right-2 = last-child.group-name + ".east"
      let left = ((a, b) => (calc.min(a.at(0), b.at(0)), a.at(1) + 0.5, 0), left-1, left-2)
      let right = ((a, b) => (calc.max(a.at(0), b.at(0)), a.at(1) + 0.5, 0), right-1, right-2)
      line(name: "line", left, right)
      if node.label != none {
        content((rel: (0.2, 0), to: "line.end"), [#node.label], anchor: "west")
      }
    }
    let build-element(node, parent-name) = {
      let name = if parent-name != none {
        parent-name + "-" + str(node.n)
      } else {
        "0"
      }
      node.name = name
      node.group-name = "g" + name
      node.element = {
        anchor(node.name, (node.x, node.y))
        group(name: node.group-name, {
          move-to((node.x, node.y))
          anchor("default", ())
          draw-node(node)
        })
      }
      node.children = node.children.map(c => build-element(c, name))
      node.edges = if node.children != () {
        group(draw-bar(node))
      } else { () }
      return node
    }
    let root = build-node(root)
    let (nodes, ..) = layout-node(root, 0)
    let node = build-element(nodes, none)
    let render(node) = {
      if node.element != none {
        node.element
        for child in node.children {
          render(child)
        }
        node.edges
      }
    }
    group(name: none, render(node))
  })
}
